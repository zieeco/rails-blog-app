module AlertHelper
  def build_alert_classes(alert_type)
    classes = 'alert alert-dismissable '
    classes + case alert_type.to_sym
              when :alert, :danger, :error, :validation_errors
                'alert-danger'
              when :warning, :todo
                'alert-warning'
              when :notice, :success
                'alert-success'
              else
                'alert-info'
              end
  end
end
