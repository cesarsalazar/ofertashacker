When /^I follow "([^"]*)" and click OK$/ do |text|
  page.evaluate_script("window.alert = function(msg) { return true; }")
  page.evaluate_script("window.confirm = function(msg) { return true; }")
  When %{I follow "#{text}"}
end

Given /^there are "([^"]*)" job vacancies of each job type$/ do |number|
  company = Factory(:company)
  number.to_i.times do
    Factory(:job, :full_time => true, :part_time => false, :flexible => false, :remote => false, :company => company, :title => "Trabajo de Tiempo Completo")
    Factory(:job, :full_time => false, :part_time => true, :flexible => false, :remote => false, :company => company, :title => "Trabajo de Medio Tiempo")
    Factory(:job, :full_time => false, :part_time => false, :flexible => false, :remote => true, :company => company, :title => "Trabajo Remoto")
    Factory(:job, :full_time => false, :part_time => false, :flexible => true, :remote => false, :company => company, :title => "Trabajo de Horario Flexible")
  end
end

Given /^there is a job vacancy of each job type$/ do
  company = Factory(:company)
  Factory(:job, :full_time => true, :part_time => false, :flexible => false, :remote => false, :company => company, :title => "Trabajo de Tiempo Completo")
  Factory(:job, :full_time => false, :part_time => true, :flexible => false, :remote => false, :company => company, :title => "Trabajo de Medio Tiempo")
  Factory(:job, :full_time => false, :part_time => false, :flexible => false, :remote => true, :company => company, :title => "Trabajo Remoto")
  Factory(:job, :full_time => false, :part_time => false, :flexible => true, :remote => false, :company => company, :title => "Trabajo de Horario Flexible")
end


Given /^there is a job vacancy with title "([^"]*)" created by "([^"]*)"$/ do |title, email|
  @company = Company.find_by_email(email)
  if !@company
    @company = Factory(:company, :email => email)
  end
  @job = Factory(:job, :company => @company, :title => title)
end

Given /^there is a job vacancy with title "([^"]*)" created by "([^"]*)" with required skill "([^"]*)"$/ do |title, email, rs|
  @company = Company.find_by_email(email)
  @rsa = Factory(:required_skill, :skill_name => rs)
  if !@company
    @company = Factory(:company, :email => email)
  end
  @job = Factory(:job, :company => @company, :title => title)
  @job.required_skill_ids_string="#{@rsa.id}"
end

Given /^there is a job vacancy with title "([^"]*)" created by "([^"]*)" and description "([^"]*)"$/ do |title, email, description|
  @company = Company.find_by_email(email)
  if !@company
    @company = Factory(:company, :email => email)
  end
  @job = Factory(:job, :company => @company, :title => title, :description => description)
end


Then /^I should see the job vacancy details for "([^"]*)"$/ do |job_name|
  job = Job.find_by_title(job_name)
  
  page.should have_content(job.title)
  page.should have_content(job.city)
  page.should have_content(job.description)
  page.should have_content("Tiempo Completo") unless job.full_time.blank? 
  page.should have_content("Medio Tiempo") unless job.part_time.blank?   
  page.should have_content("Horario Flexible") unless job.flexible.blank? 
  page.should have_content("Remoto") unless job.remote.blank?
end

