require 'test_helper'

class Api::V1::NotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create :user
  end

  test 'should get index' do
    create :note, user: @user
    create :note, user: @user
    get api_v1_notes_path, params: { user_id: @user.id }
  end

  test 'should create notes' do
    notes_params = [{ name: 'some_name', description: '' },
                    { name: 'some_name_1', description: 'some_description_1' }]
    user = create :user
    params = { user_id: user.id, notes: notes_params }
    post api_v1_notes_path, params: params
    assert_response :success
    assert_equal 2, Note.count
    assert_equal 'ok', JSON.parse(response.body)['code']
  end

  test 'should destroy notes' do
    user = create :user
    note1 = create :note, user: user
    note2 = create :note, user: user
    delete remove_multiple_api_v1_notes_path, params: { ids: [note1.id, note2.id] }
    assert_response :success
    assert_equal 0, Note.count
  end

  test 'should show note' do
    user = create :user
    note = create :note, user: user
    get api_v1_note_url(id: note.id)
    assert_response :success
    assert_equal note.id, JSON.parse(response.body)['id']
  end

  test 'should update notes' do
    user = create :user
    note1 = create :note, user: user
    note2 = create :note, user: user
    params = [{ id: note1.id, name: ['some_string'] },
              { id: note2.id, description: 'some_string_2' }]
    patch update_multiple_api_v1_notes_path, params: { notes: params }
    assert_response :success
    note1.reload
    note2.reload
    assert_equal 'some_string', note1.name
    assert_equal 'some_string_2', note2.description
  end
end
