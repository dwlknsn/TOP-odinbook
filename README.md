https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project

Data modelling and UI design:

![TOP-odinbook](https://github.com/user-attachments/assets/ccb90176-9d3f-46c3-a128-b86ce90ccc65)


Todo

Deployment

- [x] Push to production!

Registration

- [x] User can create an account (Devise - email/password)
- [x] User can create an account (OAuth)
- [x] Welcome email (letter_opener)
- [ ] Welcome email (Sendgrid?)

Profile

- [x] User can edit their profile
- [x] User can add an avatar
- [x] Gravatar fallback for Avatar
- [x] Avatar image preview in profile edit page

Posts

- [x] User can author a draft post
- [x] User can publish a post
- [x] User can edit a post
- [x] Make posts rich text with ActionText/Trix
- [x] User can add pictures to a post
- [x] User can archive a post
- [x] User can view posts in a feed in preview format
- [x] User can view a full post with its comments
- [x] Separate feeds for followed posts and discoverable posts
- [x] infinite scroll on posts
- [x] Split Posts feed into followed users' posts and discoverable (i.e. unfollowed users') posts

Likes

- [x] User can like a post
- [x] Display likes count for post
- [x] User can remove like from a post
- [x] User can like a comment
- [x] User can remove like from a comment

Comments

- [x] User can comment on a post
- [x] User can comment on a comment
- [x] Display comment count for a post (include all sub-comments)
- [x] Add counter-cache for comments
- [x] User can remove own comment from a post
- [x] Comments with sub-comments are soft deleted. Sub-comments remain visible
- [x] User can remove own comment from a comment
- [ ] pagination on comments

Following Users

- [x] User can request to follow another user
- [x] User can cancel request to follow another user
- [x] User can accept/decline a follow request
- [x] User can block another user (i.e. other user cannot see the blocking user's posts)
- [x] update users page to separate following accepted from pending

Notifications

- [x] Notifications about likes on your posts and comments
- [ ] Notifications about comments on your posts and comments

Usability/UX/Misc Extra Features

- [x] Dark Mode - based on both browser preference and with a toggle in the UI
- [x] Integrate AWS S3 for image uploads
- [x] Cron/job for simulating likes on posts, so that the notifications stream is populated
- [ ] Cron/job for simulating comments on posts, so that the notifications stream is populated
- [ ] skeleton placeholder dom elements for loading items
- [ ] Better color palette
- [ ] Private Message chat?
- [ ] Separate public and private posts
- [ ] User can schedule a post to be published at a future date
- [ ] User can mute another user (i.e. remove their posts from all feeds)
- [ ] User can unmute another user
