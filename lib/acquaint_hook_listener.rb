class AcquaintHookListener < Redmine::Hook::ViewListener
  def view_issues_sidebar_issues_bottom(context={})
    @acquaints = Acquaint.where(issue: context[:issue]);
    context[:controller].send(:render_to_string, {
      :partial => "acquaint/acquaintroot",
      :locals => { acquaints: Acquaint.all }
      })
  end
end
