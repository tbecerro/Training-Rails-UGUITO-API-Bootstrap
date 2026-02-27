module Api
  module V1
    class NotesController < ApplicationController
      before_action :validate_type_param, only: [:index]
      before_action :validate_order_param, only: [:index]

      def index
        render json: response_notes_index, status: :ok
      end

      def show
        render json: Note.find(params.require(:id)), status: :ok
      end

      private

      def notes_filtered
        Note.where(params.permit(:note_type))
      end

      def order_notes
        notes_filtered.order(created_at: params[:order] || :asc)
      end

      def response_notes_index
        order_notes.page(params[:page]).per(params[:page_size])
      end

      def validate_type_param
        allowed_types = %w[review critique]
        return if !params[:note_type] || allowed_types.include?(params[:note_type].to_s)
        render json: { error: I18n.t('active_record.note_controller.error.note_type_param') },
               status: :bad_request
      end

      def validate_order_param
        allowed_types = %w[asc desc]
        return if !params[:order] || allowed_types.include?(params[:order].to_s)

        render json: { error: I18n.t('active_record.note_controller.error.order_param') },
               status: :bad_request
      end
    end
  end
end
