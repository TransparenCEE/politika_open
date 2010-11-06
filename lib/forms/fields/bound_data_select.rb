module Forms
  module Fields
    class BoundDataSelect < DataSelect
      def setup
        self.settings.merge!({
          :grouped      => true,
          :prompt       => "",
          :html_options => {
            :class => "bound",
            :"data-bound-to" => "#{@form.object.class.name.downcase}_#{form.identifier}_#{settings[:bound_to]}"
          }
        })
      end
    end
  end
end