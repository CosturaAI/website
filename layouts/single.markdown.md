# {{ .Title }}

> {{ .Description }}

Published {{ .Date.Format "2006-01-02" }}{{ with .Params.authors }} by {{ delimit . ", " " and " }}{{ end }}. Canonical: {{ .Permalink }}

{{ .RawContent }}
