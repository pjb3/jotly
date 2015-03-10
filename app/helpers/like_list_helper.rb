module LikeListHelper
  def like_list(jot)
    "Liked by #{full_suffix(jot).strip}.".html_safe
  end

  private
  def full_suffix(jot)
    if jot.likes.size == 0
      'no one yet'
    else
      liked_by_current_user = jot.likes.where(user_id: current_user.id).any?

      likes_besides_current_user = begin
        if liked_by_current_user
          jot.likes.reject {|like| like.user_id == current_user.id }.first(2)
        else
          jot.likes.first(3)
        end
      end
      [
        you_prefix(liked_by_current_user, likes_besides_current_user),
        list_of_user_links(likes_besides_current_user.map(&:user)),
        others_suffix(jot.likes.size - 3)
      ].compact.join(' ')
    end
  end

  def you_prefix(liked_by_current_user, likes_besides_current_user)
    if liked_by_current_user
      suffix = likes_besides_current_user.any? ? ' and' : ''
      "You#{suffix}"
    end
  end

  def others_suffix(number)
    if number > 0
      "and #{pluralize(number, 'other')}"
    end
  end

  def list_of_user_links(users)
    users.map { |user| "<a>#{user.name}</a>" }.join(', ')
  end
end
