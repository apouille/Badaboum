module ConversationsHelper
  def check_user_first_name!
    if current_user.profile.first_name == nil
        flash[:error] = "Remplis ton profil pour pouvoir écrire un message !"
        redirect_to edit_profile_path
    end
  end
end
