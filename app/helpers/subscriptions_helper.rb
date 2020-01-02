# frozen_string_literal: true

# module SubscriptionsHelper
module SubscriptionsHelper
  def find_user_sub(subscriptionable_id, subscriptionable_type)
    Subscription.find_by(subscriptionable_id: subscriptionable_id,
                         subscriptionable_type: subscriptionable_type,
                         user_id: current_user.id)
  end
end
