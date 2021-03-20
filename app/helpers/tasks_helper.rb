module TasksHelper
  def button_label
    if action_name == 'new'
      t('view.submit_task')
    elsif action_name == 'edit'
      t('view.update_task')
    end
  end
end
