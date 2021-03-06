module NotesHelper

  def find_notes(user_id)
    notes = []
    friendships = get_friendships(user_id, 'confirmed')

    notes = Note.where(user_id: user_id.to_i)

    friendships.each do |friendship|
      friendship.user_id == user_id.to_i ? id = friendship.friend_id  : id = friendship.user_id
      notes = notes +  Note.where(user_id: id)
    end

    notes = notes.group_by(&:user_id)        
  end

  def user_session_is_admin?
    if logged?
      admin = User.where(user_name: session[:user_name]).first.admin
    end
    admin
  end

  def get_users_to_edit(note_id)
    note = Note.find(note_id)
    note.note_permission.user - Array.wrap(note.user)
  end

  def get_users_cant_edit(note_id)
    note = Note.find(note_id)
    User.where.not(id: note.note_permission.user_ids)
  end

  def get_notes(user_id)
    note = Note.where(user_id: user_id)
  end

  def logged?
    session[:user_name]
  end
end
