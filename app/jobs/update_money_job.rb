# update_money_job.rb
class UpdateMoneyJob < ApplicationJob
  queue_as :default

  def perform(money)
    sleep 1.5
    Spin.new.broadcast_update_to("slot-machine", target: "money", partial: "home/money", locals: { money: money })
  end
end
