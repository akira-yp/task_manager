module TasksHelper
  def button_label
    if action_name == 'new' || action_name == 'create'
      t('view.submit_task')
    elsif action_name == 'edit'
      t('view.update_task')
    end
  end
end
