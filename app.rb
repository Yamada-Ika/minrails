# frozen_string_literal: true

class HelloApp
  def call(env)
	# [200, {'Content-Type' => 'text/plain'}, ['Hello World']]
	[200, {'Content-Type' => 'text/plain'}, ['Hello World']]
	[200, {}, ['Hello World']]
  end
end
