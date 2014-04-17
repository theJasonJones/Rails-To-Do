require 'spec_helper'

describe "todo_lists/edit" do
  before(:each) do
    @todo_list = assign(:todo_list, stub_model(TodoList,
      :title => "MyString",
      :description => "MyString",
      :text => "MyString"
    ))
  end

  it "renders the edit todo_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", todo_list_path(@todo_list), "post" do
      assert_select "input#todo_list_title[name=?]", "todo_list[title]"
      assert_select "input#todo_list_description[name=?]", "todo_list[description]"
      assert_select "input#todo_list_text[name=?]", "todo_list[text]"
    end
  end
end
