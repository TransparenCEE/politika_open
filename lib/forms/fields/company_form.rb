module Forms
  module Fields
    class CompanyForm < DataSelect
      def setup
        self.settings.merge!({
          :data_source  => "company.form",
          :grouped      => true,
          :prompt       => "",
          :html_options => {
            :class => "bound",
            :"data-bound-to" => "#{@form.object.class.name.downcase}_#{form.identifier}_sector"
          }
        })
        
      end
    end
  end
end