# frozen_string_literal: true

::Spina::Theme.register do |theme| # rubocop:disable Metrics/BlockLength
  theme.name = 'conferences_primer_theme'
  theme.title = 'Conferences Primer theme'

  theme.page_parts = [{
    name: 'text',
    title: 'Text',
    partable_type: 'Spina::Text'
  }, {
    name: 'gallery',
    title: 'Gallery',
    partable_type: 'Spina::ImageCollection'
  }, {
    name: 'constitution',
    title: 'Constitution',
    partable_type: 'Spina::Attachment'
  }, {
    name: 'slides',
    title: 'Slides',
    partable_type: 'Spina::Attachment'
  }, {
    name: 'handout',
    title: 'Handout',
    partable_type: 'Spina::Attachment'
  }, {
    name: 'poster',
    title: 'Poster',
    partable_type: 'Spina::Attachment'
  }, {
    name: 'partner_societies',
    title: 'Partner societies',
    partable_type: 'Spina::Structure'
  }, {
    name: 'minutes',
    title: 'Minutes',
    partable_type: 'Spina::Structure'
  }, {
    name: 'contact',
    title: 'Contact',
    partable_type: 'Spina::Text'
  }, {
    name: 'socials',
    title: 'Socials',
    partable_type: 'Spina::Structure'
  }, {
    name: 'meetings',
    title: 'Meetings',
    partable_type: 'Spina::Structure'
  }, {
    name: 'submission_url',
    title: 'Submission URL',
    partable_type: 'Spina::Admin::Conferences::UrlPart'
  }, {
    name: 'submission_date',
    title: 'Submission date',
    partable_type: 'Spina::Admin::Conferences::DatePart'
  }, {
    name: 'submission_text',
    title: 'Submission text',
    partable_type: 'Spina::Line'
  }, {
    name: 'committee_bios',
    title: 'Committee bios',
    partable_type: 'Spina::Structure'
  }, {
    name: 'sponsors',
    title: 'Sponsors',
    partable_type: 'Spina::Structure'
  }]

  theme.layout_parts = [{
    name: 'current_conference_alert',
    title: 'Alert',
    partable_type: 'Spina::Line'
  }, {
    name: 'github_url',
    title: 'GitHub URL',
    partable_type: 'Spina::Line'
  }]

  theme.structures = [{
    name: 'partner_societies',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'logo',
      title: 'Logo',
      partable_type: 'Spina::Image'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }, {
      name: 'website',
      title: 'Website',
      partable_type: 'Spina::Admin::Conferences::UrlPart'
    }, {
      name: 'email_address',
      title: 'Email address',
      partable_type: 'Spina::Admin::Conferences::EmailAddressPart'
    }]
  }, {
    name: 'minutes',
    structure_parts: [{
      name: 'date',
      title: 'Date',
      partable_type: 'Spina::Admin::Conferences::DatePart'
    }, {
      name: 'attachment',
      title: 'Attachment',
      partable_type: 'Spina::Attachment'
    }]
  }, {
    name: 'socials',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'start_time',
      title: 'Time',
      partable_type: 'Spina::Admin::Conferences::TimePart'
    }, {
      name: 'location',
      title: 'Location',
      partable_type: 'Spina::Line'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }]
  }, {
    name: 'meetings',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'start_time',
      title: 'Time',
      partable_type: 'Spina::Admin::Conferences::TimePart'
    }, {
      name: 'location',
      title: 'Location',
      partable_type: 'Spina::Line'
    }, {
      name: 'description',
      title: 'Description',
      partable_type: 'Spina::Text'
    }]
  }, {
    name: 'committee_bios',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'institution',
      title: 'Institution',
      partable_type: 'Spina::Line'
    }, {
      name: 'role',
      title: 'Role',
      partable_type: 'Spina::Line'
    }, {
      name: 'bio',
      title: 'Bio',
      partable_type: 'Spina::Text'
    }, {
      name: 'profile_picture',
      title: 'Profile picture',
      partable_type: 'Spina::Image'
    }, {
      name: 'facebook_profile',
      title: 'Facebook profile',
      partable_type: 'Spina::Admin::Conferences::UrlPart'
    }, {
      name: 'twitter_profile',
      title: 'Twitter profile',
      partable_type: 'Spina::Admin::Conferences::UrlPart'
    }]
  }, {
    name: 'sponsors',
    structure_parts: [{
      name: 'name',
      title: 'Name',
      partable_type: 'Spina::Line'
    }, {
      name: 'logo',
      title: 'Logo',
      partable_type: 'Spina::Image'
    }, {
      name: 'website',
      title: 'Website',
      partable_type: 'Spina::Admin::Conferences::UrlPart'
    }]
  }]

  theme.view_templates = [{
    name: 'homepage',
    title: 'Homepage',
    page_parts: %w[gallery text]
  }, {
    name: 'information',
    title: 'Information',
    description: 'Contains general information',
    page_parts: %w[text]
  }, {
    name: 'committee',
    title: 'Committee',
    description: 'Contains committee bios',
    page_parts: %w[text committee_bios]
  }, {
    name: 'about',
    title: 'About',
    description: 'Contains information about the society',
    page_parts: %w[text constitution minutes partner_societies contact]
  }, {
    name: 'show',
    title: 'Blank',
    description: 'Blank template',
    page_parts: []
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

  theme.plugins = ['conferences']
end
