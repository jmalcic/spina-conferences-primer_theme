# frozen_string_literal: true

module Spina
  module PrimerTheme
    # Breadcrumbs for the frontend.
    module Breadcrumbs
      # Custom builder using Primer breadcrumbs.
      class Builder < BreadcrumbsOnRails::Breadcrumbs::Builder
        def render
          @context.render ::Primer::BreadcrumbComponent.new(mb: 4) do |component|
            @context.safe_join(render_elements(component, @elements), "\n")
          end
        end

        private

        def render_elements(component, elements)
          elements.collect { |element| render_element(component, element) }
        end

        def render_element(component, element)
          url = compute_path(element)
          if @context.current_page? url
            component.item(selected: true, **element.options) { compute_name(element) }
          else
            component.item(href: compute_path(element), **element.options) { compute_name(element) }
          end
        end
      end
    end
  end
end
