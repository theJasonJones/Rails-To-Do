require 'spec_helper'

describe "Creating todo lists"  do
	def create_todo_list(options={})
		options[:title] ||= "My To-Do List"
		options[:description] ||= "Learn Rails"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		#Add values to textboxes
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "Redirects to the todo list index page on success" do
		create_todo_list
		#Check for content
		expect(page).to have_content("My To-Do List")
	end

	it "Displays an error when the todo list has no title" do
		#Check for zero posts
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		#Page should have an error
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Learn Rails") 
	end


	it "Displays a title error when the title is less than 3 characters" do
		expect(TodoList.count).to eq(0)
		create_todo_list title: "Hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Learn Rails")
	end

	it "Displays a error when description is blank" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "My To-Do List", description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Learn This")
	end

	it "Displays a description error when the description is less than 5 characters" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "My To-Do List", description: "dawg"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("Yo, ")
	end
end