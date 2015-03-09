module ApplicationHelper
  def jot_author_or_second_person(jot)
    if jot.user_id == current_user.try(:id)
      'You'
    else
      jot.user.name
    end
  end
end
