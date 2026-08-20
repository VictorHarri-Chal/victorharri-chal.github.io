#!/usr/bin/env ruby
# frozen_string_literal: true

# Renders the running Rails app into a static site under _site/.
#
#   bin/rails server -e production -p 3000 -b 127.0.0.1 &
#   ruby script/build_static.rb
#
# The page list comes from config/projects.yml, so adding a project needs no
# change here. Every page is checked before it is written: a non-200, an empty
# body or a Rails exception page aborts the build instead of publishing it.
#
# Pages are written as <path>/index.html. The repository is a user site served
# from the domain root, so the absolute paths Rails emits already resolve and
# nothing needs rewriting afterwards. A copy is also written at <path>.html to
# keep the URLs the site published previously working.

require "fileutils"
require "net/http"
require "uri"
require "yaml"

ROOT = File.expand_path("..", __dir__)
OUTPUT = File.join(ROOT, "_site")
HOST = ENV.fetch("STATIC_HOST", "http://127.0.0.1:3000")
EXCEPTION_MARKER = "Action Controller: Exception"
SITE_URL = "https://victorharri-chal.github.io"
COPIED_FILES = %w[404.html icon.svg icon.png og-image.png robots.txt CV_Victor_Harri-Chal.pdf].freeze

def project_slugs
  YAML.load_file(File.join(ROOT, "config", "projects.yml"))
      .fetch("featured")
      .map { |project| project.fetch("slug") }
end

def pages
  [ "/", "/about", "/experience", "/contact", "/projects" ] + project_slugs.map { |slug| "/projects/#{slug}" }
end

def wait_for_server
  30.times do
    response = Net::HTTP.get_response(URI.join(HOST, "/up"))
    return if response.code == "200"
  rescue SystemCallError, IOError
    # not listening yet
  ensure
    sleep 1
  end
  abort "✗ no server answering on #{HOST}"
end

def fetch(path)
  response = Net::HTTP.get_response(URI.join(HOST, path))
  body = response.body.to_s

  abort "✗ #{path} → HTTP #{response.code}" unless response.code == "200"
  abort "✗ #{path} → empty response" if body.strip.empty?
  abort "✗ #{path} → Rails exception page" if body.include?(EXCEPTION_MARKER)

  body
end

def write(path, body)
  targets = [ path == "/" ? "index.html" : File.join(path.delete_prefix("/"), "index.html") ]
  targets << "#{path.delete_prefix("/")}.html" unless path == "/"

  targets.each do |target|
    destination = File.join(OUTPUT, target)
    FileUtils.mkdir_p(File.dirname(destination))
    File.write(destination, body)
  end
end

def write_sitemap(paths)
  urls = paths.map { |path| "  <url><loc>#{SITE_URL}#{path}</loc></url>" }
  File.write(File.join(OUTPUT, "sitemap.xml"), <<~XML)
    <?xml version="1.0" encoding="UTF-8"?>
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
    #{urls.join("\n")}
    </urlset>
  XML
end

def copy_static_files
  assets = File.join(ROOT, "public", "assets")
  FileUtils.cp_r(assets, OUTPUT) if Dir.exist?(assets)

  COPIED_FILES.each do |name|
    source = File.join(ROOT, "public", name)
    FileUtils.cp(source, File.join(OUTPUT, name)) if File.exist?(source)
  end

  # Tells GitHub Pages to publish the directory as-is rather than run Jekyll.
  FileUtils.touch(File.join(OUTPUT, ".nojekyll"))
end

FileUtils.rm_rf(OUTPUT)
FileUtils.mkdir_p(OUTPUT)

wait_for_server

pages.each do |path|
  body = fetch(path)
  write(path, body)
  puts format("  %-26s %6d bytes", path, body.bytesize)
end

copy_static_files
write_sitemap(pages)

written = Dir.glob(File.join(OUTPUT, "**", "*.html")).size
puts "\n✓ #{pages.size} pages rendered, #{written} HTML files written to _site/"
