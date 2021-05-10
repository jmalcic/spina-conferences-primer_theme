# frozen_string_literal: true

module Spina
  Account.first_or_create name: 'Primer', theme: 'conferences_primer_theme'
  User.first_or_create name: 'Joe', email: 'someone@someaddress.com', password: 'password', admin: true
  module Admin
    module Conferences
      university_of_atlantis, university_of_shangri_la =
        Institution.create! [{ name: 'University of Atlantis', city: 'Atlantis' },
                             { name: 'University of Shangri-La', city: 'Shangri-La' }]
      lecture_block2, _lecture_block3, _lecture_block_entrance =
        Room.create! [{ building: 'Lecture block', number: '2', institution: university_of_atlantis },
                      { building: 'Lecture block', number: '3', institution: university_of_atlantis },
                      { building: 'Lecture block', number: 'entrance', institution: university_of_atlantis }]
      _medical_school_g14, _medical_school_g152, _medical_school_g16 =
        Room.create! [{ building: 'Medical school', number: 'G.14', institution: university_of_shangri_la },
                      { building: 'Medical school', number: 'G.152', institution: university_of_shangri_la },
                      { building: 'Medical school', number: 'G.16', institution: university_of_shangri_la }]
      uoa_conference, uos_conference =
        Conference.create! [{ start_date: '2017-04-07', finish_date: '2017-04-09', name: 'University of Atlantis 2017' },
                            { start_date: '2018-04-09', finish_date: '2018-04-11', name: 'University of Shangri-La 2018' }]
      _plenary1, _poster1, talk1, _plenary2, _poster2, _talk2 =
        PresentationType.create! [{ name: 'Plenary', minutes: 80, conference: uoa_conference },
                                  { name: 'Poster', minutes: 30, conference: uoa_conference },
                                  { name: 'Talk', minutes: 20, conference: uoa_conference },
                                  { name: 'Plenary', minutes: 80, conference: uos_conference },
                                  { name: 'Poster', minutes: 30, conference: uos_conference },
                                  { name: 'Talk', minutes: 20, conference: uos_conference }]
      session = Session.create! presentation_type: talk1, room: lecture_block2, name: 'Session'
      joe_bloggs = Delegate.create! first_name: 'Joe', last_name: 'Bloggs', email_address: 'someone@someaddress.com',
                                    institution: university_of_atlantis,
                                    dietary_requirements: [DietaryRequirement.new(name: 'Pescetarian')],
                                    conferences: [uoa_conference, uos_conference]
      Presentation.create! [{ title: 'The Asymmetry and Antisymmetry of Syntax', start_datetime: '2017-04-07T10:00',
                              abstract: 'Lorem ipsum', presenters: [joe_bloggs],
                              session: session },
                            { title: 'The Wonders of Language', start_datetime: '2017-04-07T15:00',
                              abstract: 'Dolor sit amet', presenters: [joe_bloggs],
                              session: session },
                            { title: 'The Language of Wonders', start_datetime: '2017-04-08T08:00',
                              abstract: 'Dolor sit amet', presenters: [joe_bloggs],
                              session: session }]
    end

    module Journal
      journal = Journal.first_or_create name: 'The Best Journal', singleton_guard: 0
      vol1, vol2 = Volume.create! [{ journal: journal, number: 1 },
                                   { journal: journal, number: 2 }]
      vol1_issue1, vol1_issue2 = Issue.create! [{ volume: vol1, number: 1, date: '2020-12-25' },
                                                { volume: vol1, number: 2, date: '2020-12-25' }]
      vol2_issue1, vol2_issue2 = Issue.create! [{ volume: vol2, number: 1, date: '2020-12-25' },
                                                { volume: vol2, number: 2, date: '2020-12-25' }]
      vol1_issue1_article1, vol1_issue1_article2 = Article.create! [{ issue: vol1_issue1, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol1_issue1, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      vol1_issue2_article1, vol1_issue2_article2 = Article.create! [{ issue: vol1_issue2, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol1_issue2, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      vol2_issue1_article1, vol2_issue1_article2 = Article.create! [{ issue: vol2_issue1, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol2_issue1, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      vol2_issue2_article1, vol2_issue2_article2 = Article.create! [{ issue: vol2_issue2, number: 1, title: 'Test title' }, # rubocop:disable Layout/LineLength
                                                                    { issue: vol2_issue2, number: 2, title: 'Test title' }] # rubocop:disable Layout/LineLength
      institution_country_house, institution_jordan_college = Institution.create! [{ name: 'Country House' },
                                                                                   { name: 'Jordan College, Oxford' }]

      affiliation_attrs_ernold = [{ institution: institution_jordan_college, first_name: 'Dan', surname: 'Abnormal', status: 'primary' }] # rubocop:disable Layout/LineLength
      affiliation_attrs_dan = [{ institution: institution_country_house, first_name: 'Ernold', surname: 'Same', status: 'primary' }] # rubocop:disable Layout/LineLength
      author_ernold, author_dan = Author.create! [{ affiliations_attributes: affiliation_attrs_ernold },
                                                  { affiliations_attributes: affiliation_attrs_dan }]

      Authorship.create! [{ article: vol1_issue1_article1, affiliation: author_ernold.primary_affiliation },
                          { article: vol1_issue1_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol1_issue1_article2, affiliation: author_dan.primary_affiliation },
                          { article: vol1_issue2_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol1_issue2_article2, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue1_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue1_article2, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue2_article1, affiliation: author_dan.primary_affiliation },
                          { article: vol2_issue2_article2, affiliation: author_dan.primary_affiliation }]
    end
  end
end
