FROM node:12-alpine
COPY package* ./
RUN npm install -g foreman && npm install
COPY . .
EXPOSE 5000
CMD ["nf", "start"]
