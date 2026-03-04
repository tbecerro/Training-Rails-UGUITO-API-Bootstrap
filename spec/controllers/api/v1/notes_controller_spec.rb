require 'rails_helper'

describe Api::V1::NotesController, type: :controller do
  describe 'GET #index' do
    context 'when there is a user logged in' do
      include_context 'with authenticated user'
    

      context 'when fetching all the notes for user' do
        let(:notes) { create_list(:note, 10, user: user) }

        before { get :index }

        it 'responds with 200 status' do
          expect(response).to have_http_status(:ok)
        end

      end

      context 'with invalid note_type filter' do
        let(:notes) { create_list(:note, 10, user: user) }
        before { get :index, params: { note_type: 'invalid_type' } }

        it 'returns bad request' do
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns error message with valid options' do
          expect(response_body['error']).to include(Note.note_type_keys.join(' or '))
        end
      end

      context 'with invalid order param' do
        before { get :index, params: { order: 'invalid_order' } }

        it 'returns bad request' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'with valid note_type filter' do
        let!(:review_notes) { create_list(:note, 2, user: user, note_type: :review) }
        let!(:critique_notes) { create_list(:note, 3, user: user, note_type: :critique) }

        before { get :index, params: { note_type: 'review' } }

        it 'returns only review notes' do
          expect(response_body.size).to eq(2)
        end
      end

      context 'with valid order param' do
        let!(:old_note) { create(:note, user: user, created_at: 1.day.ago) }
        let!(:new_note) { create(:note, user: user, created_at: 1.hour.ago) }

        context 'when order is asc' do
          before { get :index, params: { order: 'asc' } }

          it 'returns notes in ascending order' do
            expect(response_body.first['id']).to eq(old_note.id)
          end
        end

        context 'when order is desc' do
          before { get :index, params: { order: 'desc' } }

          it 'returns notes in descending order' do
            expect(response_body.first['id']).to eq(new_note.id)
          end
        end
      end
    end


    context 'with pagination' do
              include_context 'with authenticated user'

      let!(:all_notes) { create_list(:note, 5, user: user) }

      context 'with page and page_size' do
        before { get :index, params: { page: 1, page_size: 2 } }

        it 'returns limited notes' do
          expect(response_body.size).to eq(2)
        end
      end

      context 'without pagination params' do
        before { get :index }

        it 'returns all notes' do
          expect(response_body.size).to eq(5)
        end
      end
    end
  end
  
  describe 'GET #show' do
    context 'when user is authenticated' do
      include_context 'with authenticated user'
      let!(:note) { create(:note, user: user) }

      context 'with existing note' do
        before { get :show, params: { id: note.id } }

        it 'returns the note' do
          expect(response_body['id']).to eq(note.id)
        end

        it 'returns ok status' do
          expect(response).to have_http_status(:ok)
        end

        it 'serializes with ShowNoteSerializer' do 
          expect(response_body.keys).to include('id', 'title', 'content', 'note_type', 'word_count', 'created_at','content_length', 'user','word_count' )
        end
      end

      context 'with non-existent note' do
        before { get :show, params: { id: 9999 } }

        it 'returns not found' do
          expect(response).to have_http_status(:not_found)
        end
      end

    end
  end
end
