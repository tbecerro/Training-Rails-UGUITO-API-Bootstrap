module Api
  module V1
    class NotesController < ApplicationController
      def index
        notes_filtered
      end

      def show
        render json: note_by_id, status: :ok
      end

      private

      def notes_filtered
        notes = filter_by_type
        notes = pagination(notes)
        response.headers['X-Total-Count'] = notes.total_count
        response.headers['X-Total-Pages'] = notes.total_pages
        render json: notes, status: :ok
      end

      def filter_by_type
        notes = Note.all
        notes = notes.where(note_type: params[:type]) if params[:type].present?
        notes = notes.order(created_at: params[:order]) if params[:order].present?
      end

      def pagination(notes)
        page = params[:page] || 1
        page_size = params[:page_size] || 10
        notes.page(page).per(page_size)
      end

      def note_by_id
        Note.find(params.require(:id))
      end
    end
  end
end
