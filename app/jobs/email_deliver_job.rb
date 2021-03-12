class EmailDeliverJob < ApplicationJob
  queue_as :default

  def perform
    users = []
    action_plans = ActionPlan.where(notion: true)
    action_plans.each do |action_plan|
      users << action_plan.user
    end
    users.uniq!
    users.each do |user|
      UserMailer.with(user: user).check_action_plan.deliver_later
    end
  end
end
