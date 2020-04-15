class AcquaintController < ApplicationController

  def new
    acquaints = Acquaint.where(issue: params[:issue])
    ids = []
    acquaints.each do |acquaint|
      ids << acquaint.user.id
    end
    users = User.active.visible.where.not(:id => ids)
    respond_to do |format|
      format.html { redirect_to_referer_or {render :html => 'Acquaint new', :status => 200, :layout => true}}
      format.js { @context = { users: users, issue: params[:issue] } }
      format.api { render_api_ok }
    end
  end

  def add
    user_ids = []
    issue = Issue.find_by_id(params[:issue])
    if params[:user_ids]
      user_ids = params[:user_ids];
    end
    users = User.active.visible.where(:id => user_ids)
    users.each do |user|
      acquaint = Acquaint.new
      acquaint.user = user
      acquaint.issue = issue
      if acquaint.valid?
        acquaint.save
        @journal = Journal.new(journalized: issue, user: User.current)
        @journal.details << JournalDetail.new(
          property: 'attr',
          prop_key: 'acquaint',
          value:    "#{acquaint.user.firstname} добавлен в ознакомление #{User.current.name}")
        @journal.valid? ? @journal.save : nil
      end
    end

    respond_to do |format|
      format.html { redirect_to_referer_or {render :html => 'Acquaint added', :status => 200, :layout => true}}
      format.js { render inline: "location.reload();" }
      format.api { render_api_ok }
    end
  end

  def create
    acquaint = Acquaint.find_by_id(params[:id])
    acquaint.status = true;
    acquaint.valid? ? acquaint.save : nil
    @journal = Journal.new(journalized: Issue.find_by_id(acquaint.issue.id), user: User.current)
    @journal.details << JournalDetail.new(
      property: 'attr',
      prop_key: 'acquaint',
      value:    "#{acquaint.user.firstname} ознакомлен")
    @journal.valid? ? @journal.save : nil
    respond_to do |format|
      format.html { redirect_to_referer_or {render :html => 'Acquaint create', :status => 200, :layout => true}}
      format.js { render inline: "location.reload();" }
      format.api { render_api_ok }
    end
  end

  def destroy
    acquaint = Acquaint.find_by_id(params[:id])
    acquaint.delete
    @issue = Issue.find_by_id(acquaint.issue.id)
    @journal = Journal.new(journalized: @issue, user: User.current)
    @journal.details << JournalDetail.new(
      property: 'attr',
      prop_key: 'acquaint',
      value:    "#{User.current.name} удалил из ознакомления #{acquaint.user.firstname}")
    @journal.valid? ? @journal.save : nil
    respond_to do |format|
      format.html { redirect_to_referer_or {render :html => 'Acquaint remove', :status => 200, :layout => true} }
      format.js { render inline: "location.reload();" }
      format.api { render_api_ok }
    end
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  private
end
