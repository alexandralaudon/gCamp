require 'rails_helper'

feature 'Tasks' do

  background do
    User.create(first_name:'Muhammad', last_name: 'Ali', email: 'bam@pow.com', password: 'ouch', password_confirmation: 'ouch')
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')
  end

  scenario 'User creates a task' do
    visit new_project_path
    fill_in "Name", with: "Polymorphism"
    click_button 'Create Project'
    click_on '0 Tasks'
    click_link "New Task"
    

    visit project_tasks_path
    click_on('New Task')
    expect(current_path).to eq(new_task_path)

    click_button('Create Task')
    expect(page).to have_content('1 error prohibited this form from being saved:')

    fill_in "Description", with: 'Work hard, play hard'
    fill_in "Due date", with: "12/12/2015"
    click_button('Create Task')
    expect(page).to have_content('Task was successfully created!')
    expect(page).to have_content('Work hard, play hard')
  end

  scenario 'User edits and deletes a task' do
    Task.create!(description:'Play hard, Work hard', due_date: '02/02/2015')

    visit tasks_path
    click_on('Play hard, Work hard')
    click_on('Edit Task')
    fill_in "Description", with: 'Work harddd, play harddd'
    fill_in "Due date", with: "12/12/2015"
    click_button('Update Task')
    expect(page).to have_content('Task was successfully updated!')
    expect(page).to have_content('Work harddd, play harddd')
    expect(current_path).to eq(task_path(Task.first.id))

    # Ensure the other way to edit page works too
    visit tasks_path
    click_on ('Edit')
    fill_in "Description", with: 'Work wtvr, play wtvr'
    fill_in "Due date", with: "11/11/2015"
    click_button('Update Task')
    expect(page).to have_content('Task was successfully updated!')
    expect(page).to have_content('Work wtvr, play wtvr')
    expect(current_path).to eq(task_path(Task.first.id))
    visit tasks_path
    expect(page).to have_content('Work wtvr, play wtvr')
    expect(page).to have_content('11/11/2015')

    # Delete task
    click_on('Delete')
    expect(page).to have_content('Task was successfully deleted!')
    expect(page).to have_no_content('Work wtvr, play wtvr')

  end

end
