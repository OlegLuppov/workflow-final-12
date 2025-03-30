FROM golang:1.23.0 AS parcel_builder
WORKDIR /app
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /parcel_app

FROM scratch
COPY --from=parcel_builder /parcel_app /parcel_app
COPY --from=parcel_builder /app/tracker.db /tracker.db

CMD [ "/parcel_app" ]
