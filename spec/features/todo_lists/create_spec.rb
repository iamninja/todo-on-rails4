require 'spec_helper'

describe "Creating todo lists" do

	def create_todo_list(options={})
		options[:title] ||="My todo list"
		options[:description] ||= "This is my todo list."

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New todo_list")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"
	end

	it "redirects to the todo list index on success" do
		create_todo_list

		expect(page).to have_content("My todo list")
	end

	it "displays an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is a test.")


	end

	it "displays an error when the todo list has a title less than 3 chars" do
		expect(TodoList.count).to eq(0)

		create_todo_list title: "hi"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("This is a test.")


	end

	it "displays an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: ""

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("legit title")


	end

	it "displays an error when the todo list has description with less than 5 chars" do
		expect(TodoList.count).to eq(0)

		create_todo_list description: "four"

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("four")


	end
end