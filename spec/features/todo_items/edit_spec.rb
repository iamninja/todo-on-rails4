require 'spec_helper'

describe "Editing todo items" do
	let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Apples and stuff.")}
	let!(:todo_item) { todo_list.todo_items.create(content: "Milk") }

	it "is successfull with valid content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "Lots of Milk"
		click_button "Save"
		expect(page).to have_content("Saved todo list item.")
		todo_item.reload
		expect(todo_item.content).to eq("Lots of Milk")
	end

	it "is unsuccessfull with no content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: ""
		click_button "Save"
		expect(page).to have_content("That todo item could not be saved.")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

	it "is unsuccessfull with not enough content" do
		visit_todo_list(todo_list)
		within("#todo_item_#{todo_item.id}") do
			click_link "Edit"
		end
		fill_in "Content", with: "hi"
		click_button "Save"
		expect(page).to have_content("That todo item could not be saved.")
		todo_item.reload
		expect(todo_item.content).to eq("Milk")
	end

end