class ShoutBuilderService
  def initialize(klass, shout_params, user)
    @klass = klass
    @shout_params = shout_params
    @user = user
  end

  def shout
    @user.shouts.build(content: build_content)
  end

  private

  def build_content
    @klass.new(@shout_params)
  end
end