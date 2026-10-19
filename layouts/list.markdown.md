# {{ .Title }}

> {{ .Description }}

{{ .RawContent }}
{{ range .Pages.ByDate.Reverse }}
- [{{ .Title }}]({{ .Permalink }}index.md): {{ .Description }} ({{ .Date.Format "2006-01-02" }})
{{- end }}
