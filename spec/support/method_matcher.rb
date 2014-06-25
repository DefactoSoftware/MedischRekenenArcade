RSpec::Matchers.define :have_method do
  match do
    actual.instance_methods.flatten.include?(expected)
  end

  def method_exists?
    actual.instance_methods.flatten.include?(expected)
  end
end
