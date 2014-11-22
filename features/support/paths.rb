module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name, params = {})
    case page_name

    when /the home\s?page/
      '/'

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /the about page/i
      about_path(params)

    when /the posts page$/i
      posts_path(params)

    when /the second posts page$/i
      posts_path(:page => "2")

    # the "posts" page with "page=2, tags=matched"
    when /the "([^\"]*)" page with "([^\"]*)"$/i
      path = $1
      parameter_string = $2

      params = {}
      parameter_string.split(",").each do |part|
        parts = part.strip.split("=")

        key = parts[0]
        val = parts[1]

        params[key.to_sym] = val
      end

      send path.gsub(/ /, '_') + "_path", params

    when /the post page/i
      post_path(params)

    when /the create posts page/i
      posts_path(params)

    when /the login page/i
      login_path(params)

    when /the session(s?) page/i
      sessions_path(params)

    when /the signup page/i
      signup_path(params)

    when /the users page/i
      users_path(params)

    when /the new user page/i
      new_user_path(params)

    when /the (verify|verification) page/i
      verify_path(params)

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
