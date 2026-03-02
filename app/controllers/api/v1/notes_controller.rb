module Api
  module V1
    class NotesController < ApplicationController
      def index
        return invalid_filter unless valid_filter?
        return invalid_order unless valid_order?
        render json: index_note, status: :ok, each_serializer: IndexNoteSerializer
      end

      def show
        render json: Note.find(params.require(:id)), status: :ok, serializer: ShowNoteSerializer
      end

      private

      def valid_filter?
        !params[:note_type] || Note.note_type_keys.include?(params[:note_type].to_s)
      end

      def invalid_filter
        render_error(I18n.t('active_record.note_controller.error.note_type_param',
                            note_type_options: Note.note_type_keys.join(' or ')))
      end

      def valid_order?
        allowed_types = %w[asc desc]
        !params[:order] || allowed_types.include?(params[:order].to_s)
      end

      def invalid_order
        render_error(I18n.t('active_record.note_controller.error.order_param'))
      end

      def notes_filtered
        Note.where(params.permit(:note_type))
      end

      def order_notes
        return notes_filtered if params[:order].blank?
        notes_filtered.order(created_at: params[:order])
      end

      def index_note
        order_notes.page(params[:page]).per(params[:page_size])
      end

      def render_error(message)
        render json: { error: message }, status: :bad_request
      end
    end
  end
end
