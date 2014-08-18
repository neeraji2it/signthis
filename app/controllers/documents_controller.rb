class DocumentsController < ApplicationController
  before_action :authorize, except: [:public_access]
  before_action :set_document, only: [:show, :edit, :update, :destroy, :email]
  before_action :wait_for_signature!, only: [:create, :update]
  respond_to :html
  respond_to :js, only: [:email_blueprint]

  def index
    @documents = current_user.documents.order(created_at: :desc).decorate
  end

  def show
    @document = @document.decorate
  end

  def new
    @document = Document.new
  end

  def email_blueprint
    @document = Document.build(document_params, current_user)
    @document.send_blueprint_by_email
    flash[:notice] = 'Your Mediation Agreement was emailed!'
    render 'email_blueprint'
  end

  def email
    @document.send_by_email
    redirect_to @document, notice: 'Your Mediation Agreement was emailed!'
  end

  def edit
    redirect_to documents_path, alert: 'You cannot edit signed document.' unless @document.editable?
  end

  def create
    @document = Document.build(document_params, current_user)

    respond_to do |format|
      if @document.save
        format.html { redirect_to @document, notice: 'Document was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    @document.destroy!
    respond_to do |format|
      format.html { redirect_to documents_url }
    end
  end

  def public_access
    @purchase = Purchase.new
    @document = Document.joins(:link).where(links: {key: params[:key]}).first
    if !!@document
      flash[:notice] = 'Thank you. Your payment for $500 has been received. You will receive a receipt via email. You are now ready to begin the Wevorce process. A Wevorce Family Architect will follow-up with you soon.' if @document.purchased?
      @document = @document.decorate
      render action: :show
    else
      redirect_to status: 404
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:first_spouse_first_name, :first_spouse_last_name, :second_spouse_first_name, :second_spouse_last_name, :foundation_building, :parenting_planning_i, :fiscal_mapping, :document_prepping, :final_review, :parenting_planning_ii, :fiscal_mapping_ii, :parenting_planning_iii, :fiscal_mapping_iii, :first_spouse_detour_meeting, :first_spouse_detour_meeting_description, :second_spouse_detour_meeting, :second_spouse_detour_meeting_description, :price, :terms, :active, :first_spouse_email, :second_spouse_email, :billable_hour, :third_detour_meeting, :third_detour_meeting_description, :fourth_detour_meeting, :fourth_detour_meeting_description, :additional_sessions)
    end

    def wait_for_signature!
      params[:document][:active] = true
    end
end
