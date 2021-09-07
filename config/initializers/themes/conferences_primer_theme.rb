# frozen_string_literal: true

::Spina::Theme.register do |theme| # rubocop:disable Metrics/BlockLength
  theme.name = 'conferences_primer_theme'
  theme.title = 'Conferences Primer theme'

  theme.layout_parts = %w[current_conference_alert]

  theme.parts = [{
    name: 'text',
    title: 'Text',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'gallery',
    title: 'Gallery',
    part_type: 'Spina::Parts::ImageCollection'
  }, {
    name: 'constitution',
    title: 'Constitution',
    part_type: 'Spina::Parts::Attachment'
  }, {
    name: 'slides',
    title: 'Slides',
    part_type: 'Spina::Parts::Attachment'
  }, {
    name: 'handout',
    title: 'Handout',
    part_type: 'Spina::Parts::Attachment'
  }, {
    name: 'poster',
    title: 'Poster',
    part_type: 'Spina::Parts::Attachment'
  }, {
    name: 'partner_societies',
    title: 'Partner societies',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name logo email_address website description]
  }, {
    name: 'minutes',
    title: 'Minutes',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[date attachment]
  }, {
    name: 'documents',
    title: 'Documents',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name attachment]
  }, {
    name: 'contact',
    title: 'Contact',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'socials',
    title: 'Socials',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name location description]
  }, {
    name: 'meetings',
    title: 'Meetings',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name location description]
  }, {
    name: 'submission_url',
    title: 'Submission URL',
    part_type: 'Spina::Parts::Admin::Conferences::Url'
  }, {
    name: 'submission_date',
    title: 'Submission date',
    part_type: 'Spina::Parts::Admin::Conferences::Date'
  }, {
    name: 'submission_text',
    title: 'Submission text',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'committee_bios',
    title: 'Committee bios',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name institution role bio profile_picture]
  }, {
    name: 'sponsors',
    title: 'Sponsors',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name website logo]
  }, {
    name: 'events_list',
    title: 'Events',
    part_type: 'Spina::Parts::Repeater',
    parts: %w[name date start_time location description url]
  }, {
    name: 'current_conference_alert',
    title: 'Alert',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'github_url',
    title: 'GitHub URL',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'name',
    title: 'Name',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'logo',
    title: 'Logo',
    part_type: 'Spina::Parts::Image'
  }, {
    name: 'description',
    title: 'Description',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'website',
    title: 'Website',
    part_type: 'Spina::Parts::Admin::Conferences::Url'
  }, {
    name: 'email_address',
    title: 'Email address',
    part_type: 'Spina::Parts::Admin::Conferences::EmailAddress'
  }, {
    name: 'date',
    title: 'Date',
    part_type: 'Spina::Parts::Admin::Conferences::Date'
  }, {
    name: 'attachment',
    title: 'Attachment',
    part_type: 'Spina::Parts::Attachment'
  }, {
    name: 'start_time',
    title: 'Time',
    part_type: 'Spina::Parts::Admin::Conferences::Time'
  }, {
    name: 'location',
    title: 'Location',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'institution',
    title: 'Institution',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'role',
    title: 'Role',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'bio',
    title: 'Bio',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'profile_picture',
    title: 'Profile picture',
    part_type: 'Spina::Parts::Image'
  }, {
    name: 'facebook_profile',
    title: 'Facebook profile',
    part_type: 'Spina::Parts::Admin::Conferences::Url'
  }, {
    name: 'twitter_profile',
    title: 'Twitter profile',
    part_type: 'Spina::Parts::Admin::Conferences::Url'
  }, {
    name: 'url',
    title: 'Link',
    part_type: 'Spina::Parts::Admin::Conferences::Url'
  }, {
    name: 'embed_url',
    title: 'Form embed URL',
    part_type: 'Spina::Parts::Admin::Conferences::Url'
  }, {
    name: 'abstract',
    title: 'Abstract',
    part_type: 'Spina::Parts::Text'
  }, {
    name: 'cover_img',
    title: 'Cover image',
    part_type: 'Spina::Parts::Image'
  }, {
    name: 'journal_abbreviation',
    title: 'Journal Abbreviation',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'issn',
    title: 'ISSN',
    part_type: 'Spina::Parts::Line'
  }, {
    name: 'page_range',
    title: 'Page Range',
    part_type: 'Spina::Parts::Admin::Journal::PageRange'
  }, {
    name: 'is_archived',
    title: 'Archived?',
    part_type: 'Spina::Parts::Conferences::PrimerTheme::Checkbox'
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    parts: %w[gallery text]
  }, {
    name: 'information',
    title: 'Information',
    description: 'Contains general information',
    parts: %w[text]
  }, {
    name: 'committee',
    title: 'Committee',
    description: 'Contains committee bios',
    parts: %w[text committee_bios]
  }, {
    name: 'about',
    title: 'About',
    description: 'Contains information about the society',
    parts: %w[text constitution minutes documents partner_societies contact]
  }, {
    name: 'events',
    title: 'Events',
    description: 'Contains details of past and upcoming events',
    parts: %w[text events_list]
  }, {
    name: 'embedded_form',
    title: 'Embedded form',
    description: 'Contains an embedded form',
    parts: %w[text embed_url]
  }, {
    name: 'show',
    title: 'Blank',
    description: 'Blank template',
    parts: []
  }]

  theme.custom_pages = [{
    name: 'homepage',
    title: 'Homepage',
    deletable: false,
    view_template: 'homepage'
  }, {
    name: 'about',
    title: 'About',
    deletable: false,
    view_template: 'about'
  }]

  theme.navigations = [{
    name: 'main',
    label: 'Main navigation',
    auto_add_pages: true
  }, {
    name: 'footer',
    label: 'Footer'
  }]

  theme.plugins = %w[conferences journal]
end
