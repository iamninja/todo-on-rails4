require 'spec_helper'

describe "Deleting todo lists" do
	let!(:todo_list) { TodoList.create(title: "Groceries", description: "Apples and stuff") }

	it "is successful when clicking a destroy link" do
		visit "/todo_lists"

		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end
		expect(page).to_not have_content(todo_list.title)
		expect change(TodoList, :count).by(-1)
 	end
end

