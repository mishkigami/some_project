class Api::V1::NotesController < Api::V1::ApplicationController
  def index
    user = User.find(params[:user_id])
    notes = Note.where(user:)
    serialized_notes = ActiveModelSerializers::SerializableResource.new(notes, each_serializer: NoteSerializer).as_json
    render json: serialized_notes
  end

  def create
    user = User.find(params[:user_id])
    params[:notes].each do |note_params|
      Note.create(user:, name: note_params[:name], description: note_params[:description])
    end
    render json: { code: :ok }
  end

  def show
    note = Note.find(params[:id])
    serialized_note = ActiveModelSerializers::SerializableResource.new(note, each_serializer: NoteSerializer).as_json
    render json: serialized_note
  end

  def remove_multiple
    Note.where(id: params[:ids]).destroy_all
    render json: { code: :ok }
  end

  def update_multiple
    params[:notes].each do |note_params|
      note = Note.find(note_params[:id])
      note.name = note_params[:name] if note_params[:name].present?
      note.description = note_params[:description] if note_params[:description].present?
      note.save
    end
  end
end
