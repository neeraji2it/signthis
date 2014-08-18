config = {
}

config.merge!({exe_path: './bin/wkhtmltopdf-amd64'}) if Rails.env.production?

WickedPdf.config = config
