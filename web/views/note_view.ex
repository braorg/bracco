defmodule Bracco.NoteView do
  use Bracco.Web, :view

  def render("index.json", %{notes: notes}) do
    %{data: render_many(notes, Bracco.NoteView, "note.json")}
  end

  def render("show.json", %{note: note}) do
    %{data: render_one(note, Bracco.NoteView, "note.json")}
  end

  def render("note.json", %{note: note}) do
    %{id: note.id,
      user_id: note.user_id,
      title: note.title,
      description: note.description}
  end
end
