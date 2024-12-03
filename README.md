https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project

Data modelling and UI design:

![TOP-odinbook](https://github.com/user-attachments/assets/ccb90176-9d3f-46c3-a128-b86ce90ccc65)


Todo

Deployment

- [ ] Push to production!

Registration

- [x] User can create an account (Devise - email/password)
- [ ] User can create an account (OAuth)
- [ ] Welcome email (Sendgrid?)

Profile

- [x] User can edit their profile
- [x] User can add an avatar
- [x] Gravatar fallback for Avatar
- [x] Avatar image preview in profile edit page

Posts

- [x] User can author a draft post
- [ ] User can publish a post
- [x] User can edit a post
- [x] Make posts rich text with ActionText/Trix
- [x] User can add pictures to a post
- [ ] User can archive a post
- [x] User can view posts in a feed in preview format
- [x] User can view full posts with comments
- [ ] Separate public and private posts
- [ ] pagination on posts
- [ ] infinite scroll on posts
- [x] Split Posts feed into followed users' posts and discoverable (i.e. unfollowed users') posts

Likes

- [x] User can like a post
- [x] Display likes count for post
- [ ] Add counter-cache for likes
- [x] User can remove like from a post
- [x] User can like a comment
- [ ] Display likes count for comment
- [x] User can remove like from a comment

Comments

- [x] User can comment on a post
- [x] User can comment on a comment
- [ ] Display comment count for a post (include all sub-comments)
- [ ] Add counter-cache for comments
- [x] User can remove own comment from a post
- [x] Comments with sub-comments are soft deleted. Sub-comments remain visible
- [x] User can remove own comment from a comment
- [ ] pagination on comments
- [ ] infinite scroll on comments

Following Users

- [x] User can request to follow another user
- [x] User can cancel request to follow another user
- [x] User can accept/decline a follow request
- [x] User can block another user (i.e. other user cannot see the blocking user's posts)
- [ ] User can mute another user (i.e. remove their posts from all feeds)

Notifications

- [x] Notifications about likes on your posts and comments
- [ ] Notifications about comments on your posts and comments

Private Messaging

- [ ] Private Message chat?

Usability/UX

- [x] Dark Mode - bzased on both browser preference and with a toggle in the UI
- [ ] skeleton placeholder dom elements for loading items
- [ ] Turbo for updating dom elements
- [ ] color palette
