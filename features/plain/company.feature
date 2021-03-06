@companies
Feature: Company Actions

  As a company
  I want to see my company information
  And edit my company information
  And update my company information

  Background:
    Given there is a company with name "Sample Company" in city "Monterrey" and email "sample@company.com" 
    And I am logged as a "sample@company.com"

  Scenario: I can view my company information
    When I follow "Perfil"
    Then I should see the company details for "sample@company.com"

  Scenario: I can edit my company information
    And I am on the edit company page for "sample@company.com"
    Then the "company_title" field should contain "Sample Company"
    And the "company_city" field should contain "Monterrey"
    And the "company_description" field should contain "This is my company"     
    And the "company_email" field should contain "sample@company.com"

  Scenario: See all my vacancies
    And there is a job vacancy with title "Ruby Sr Programmer" created by "sample@company.com"
    And there is a job vacancy with title "Web Design" created by "sample@company.com"
    And I am on the index job page
    Then I should see "Ruby Sr Programmer"
    And I should see "Web Design"

  Scenario: I can edit my own vacancies
    And there is a job vacancy with title "Ruby on Rails" created by "sample@company.com"
    And I am on the index job page
    And I follow "Ruby on Rails"
    When I follow "Editar"
    Then I should see "Datos de la oferta"

  Scenario: I cannot edit other Companies vacancies
    And there is a job vacancy with title "Ruby on Rails" created by "company_example@company_example.com"
    And I am on the index job page
    When  I follow "Ruby on Rails"
    Then I should not see "Editar"

  Scenario: I can delete my own vacancies
    And there is a job vacancy with title "RoR" created by "sample@company.com"
    And I am on the index job page
    Then I follow "RoR"
    And I follow "Borrar"
    Then I should see "La vacante fue eliminada correctamente"

