module RailsAdmin
  module Config
    module Actions
      class Toggle < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          true
        end

        register_instance_option :controller do
          Proc.new do |klass|
            p params
            if params['id'].present?
              obj = @abstract_model.model.find(params['id'])
              method = params[:method]
              obj.send(method + '=', params[:on] == '1' ? true : false)
            end
          end
        end

        register_instance_option :link_icon do
          'icon-move'
        end

        register_instance_option :http_methods do
          [:post]
        end
      end
    end
  end
end