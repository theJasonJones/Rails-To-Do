require 'spec_helper'

describe "Creating todo lists"  do
	it "Redirects to the todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		#Add values to textboxes
		fill_in "Title", with: "My To-Do List"
		fill_in "Description", with: "Learn Rails"
		click_button "Create Todo list"

		#Check for content
		expect(page).to have_content("My To-Do List")
	end

	it "Displays an error when the todo list has no title" do
		#Check for zero posts
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: ""
		fill_in "Description", with: "Learn Rails"
		click_button "Create Todo list"

		#Page should have an error
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Learn Rails") 
	end


	it "Displays a title error when the title is less than 3 characters" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		#Test with 2 characters when 3 are required
		fill_in "Title", with: "Hi"
		fill_in "Description", with: "Learn Rails"
		click_button "Create Todo list"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Learn Rails")
	end
end