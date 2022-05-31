{{/* Common labels */}}

{{- define "app.labels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
truefoundry.com/managed-by: {{ .Values.managedBy }}
{{- end }}