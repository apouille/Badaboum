module ProfilesHelper

def has_a_profile?
	return true unless current_user.profile.first_name == nil
end

end