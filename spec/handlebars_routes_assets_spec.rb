require 'spec_helper'

def build_route name, path
  OpenStruct.new({:name => name, :path => OpenStruct.new(:ast => path)})
end

describe HandlebarsRoutesAssets do
  # the @route property basically describes a RouteSet#routes object
  # as Rails.application.routes.routes[:index] returns it
  describe 'resources#index' do
    before { @route = build_route 'users', '/users(.:format)' }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }

    it { should respond_to(:users_path) }
    its(:users_path) { should eql '/users'}
  end

  describe 'resources#show' do
    before { @route = build_route 'user', '/users/:id(.:format)' }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }

    it { should respond_to(:user_path) }
    its(:user_path) { should eql('/users/{{id}}') }
    it { subject.user_path('\d+').should eql('/users/\d+') }
  end

  describe 'resources#edit' do
    before { @route = build_route 'edit_user', '/users/:id/edit(.:format)' }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }

    it { should respond_to(:edit_user_path) }
    its(:edit_user_path) { should eql('/users/{{id}}/edit') }
  end
  
  describe 'resources without name' do
    before { @route = build_route nil, '/foo' }
    subject { HandlebarsRoutesAssets::RoutesHelper.new [@route] }
    
    it { subject.should_not_receive(:build_url) }
  end
end