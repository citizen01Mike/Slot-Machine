class SpinsController < ApplicationController
  def create
    spin_values = (1..3).map { |n| rand (1..3) }
    @spin = Spin.create(values: spin_values)
    if spin_values.uniq.size <= 1
      session[:money] += 1000 if spin_values.all? { |value| value == 1 }
      session[:money] += 500 if spin_values.all? { |value| value == 2 }
      session[:money] += 300 if spin_values.all? { |value| value == 3 }
    else
      count = spin_values.count { |v| v == 1 }
      if count == 2
        session[:money] += 200
      elsif count == 1
        session[:money] += 100
      end
    end
    render turbo_stream: turbo_stream.replace("slots", partial: "slots", locals: { spin: @spin })
    UpdateMoneyJob.perform_later(session[:money])
  end
end