#!/bin/bash

# 🚀 Auto LinkedIn Poster Setup Script
# Run this after getting your LinkedIn API credentials

echo "🤖 Auto LinkedIn Poster Setup"
echo "=============================="

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI not found. Please install it first:"
    echo "   https://cli.github.com/"
    exit 1
fi

# Get LinkedIn credentials
echo ""
echo "📝 Enter your LinkedIn API credentials:"
read -p "LinkedIn Access Token: " LINKEDIN_TOKEN
read -p "Your LinkedIn Username (from profile URL): " LINKEDIN_USERNAME

# Add secret to repository
echo ""
echo "🔐 Adding LinkedIn token to repository secrets..."
gh secret set LINKEDIN_ACCESS_TOKEN --body "$LINKEDIN_TOKEN"

if [ $? -eq 0 ]; then
    echo "✅ LinkedIn token added successfully!"
else
    echo "❌ Failed to add token. Make sure you're authenticated with GitHub CLI."
    exit 1
fi

# Update workflow file with user's LinkedIn URN
echo ""
echo "📝 Updating workflow with your LinkedIn URN..."

# Create the updated workflow content
cat > .github/workflows/daily-linkedin-poster.yml << EOF
# 🤖 GitHub Workflow: Auto LinkedIn Poster (By Sagar Majumder)
# Purpose: Automatically find trending and latest (2025 or future-related) topics from Reddit 
# and post on LinkedIn with natural writing, real sources, and smart timing.

name: Daily LinkedIn AI Poster

on:
  schedule:
    - cron: '30 4 * * *'  # 10:00 AM IST
    - cron: '30 5 * * *'  # 11:00 AM IST
    - cron: '30 16 * * *' # 10:00 PM IST
  workflow_dispatch:

jobs:
  post-to-linkedin:
    runs-on: ubuntu-latest

    steps:
      - name: 🔍 Fetch Trending Topics
        uses: actions/checkout@v3

      - name: 🧠 Generate LinkedIn Posts
        id: generate
        run: |
          python3 <<'EOF'
          import requests, random, datetime, os

          subreddits = {
            "hacking": "https://www.reddit.com/r/hacking/top.json?t=day",
            "cyber_security": "https://www.reddit.com/r/cybersecurity/top.json?t=day",
            "business": "https://www.reddit.com/r/business/top.json?t=day",
            "finance": "https://www.reddit.com/r/finance/top.json?t=day",
            "tech": "https://www.reddit.com/r/technology/top.json?t=day",
            "ai": "https://www.reddit.com/r/artificial/top.json?t=day",
            "top_secret": "https://www.reddit.com/r/conspiracy/top.json?t=day"
          }

          headers = {'User-Agent': 'SagarAI/1.0'}

          posts = []
          for topic, url in subreddits.items():
              try:
                  data = requests.get(url, headers=headers).json()
                  for post in data["data"]["children"][:6]:  # 6 posts per topic
                      title = post["data"]["title"]
                      link = "https://reddit.com" + post["data"]["permalink"]
                      post_text = f"""
🚀 {title}

💡 Summary: {title[:180]}...
🔗 Source: {link}
#Trending #AI #CyberSecurity #Business #Finance #Tech #Innovation #2025 #Future
"""
                      posts.append(post_text.strip())
              except Exception as e:
                  print(f"Error fetching {topic}: {e}")

          random.shuffle(posts)
          os.makedirs("posts", exist_ok=True)
          with open("posts/today.txt", "w", encoding="utf-8") as f:
              f.write("\n\n---\n\n".join(posts))
          EOF

      - name: 🔗 Post to LinkedIn
        env:
          LINKEDIN_ACCESS_TOKEN: \${{ secrets.LINKEDIN_ACCESS_TOKEN }}
        run: |
          python3 <<'EOF'
          import requests, time, os
          
          try:
              with open("posts/today.txt", encoding="utf-8") as f:
                  posts = f.read().split("\n\n---\n\n")

              for i, post in enumerate(posts[:3]):  # Limit to 3 posts per run
                  payload = {
                      "author": "urn:li:person:$LINKEDIN_USERNAME",
                      "lifecycleState": "PUBLISHED",
                      "specificContent": {
                          "com.linkedin.ugc.ShareContent": {
                              "shareCommentary": {"text": post},
                              "shareMediaCategory": "NONE"
                          }
                      },
                      "visibility": {"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"}
                  }

                  response = requests.post(
                      "https://api.linkedin.com/v2/ugcPosts",
                      headers={"Authorization": f"Bearer {os.getenv('LINKEDIN_ACCESS_TOKEN')}",
                               "Content-Type": "application/json"},
                      json=payload
                  )
                  
                  if response.status_code == 201:
                      print(f"✅ Post {i+1} published successfully")
                  else:
                      print(f"❌ Post {i+1} failed: {response.status_code} - {response.text}")
                  
                  if i < len(posts) - 1:  # Don't wait after last post
                      time.sleep(1800)  # wait 30 minutes before next post
          except Exception as e:
              print(f"Error posting to LinkedIn: {e}")
          EOF
EOF

# Commit the changes
git add .github/workflows/daily-linkedin-poster.yml
git commit -m "🔧 Update workflow with user's LinkedIn URN"
git push

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo "✅ LinkedIn token added to secrets"
echo "✅ Workflow updated with your LinkedIn URN"
echo "✅ Ready to start posting automatically!"
echo ""
echo "🚀 Next Steps:"
echo "1. Go to GitHub Actions tab"
echo "2. Run 'Daily LinkedIn AI Poster' manually to test"
echo "3. Check your LinkedIn for the first post!"
echo ""
echo "⏰ Automatic posting schedule:"
echo "   • 10:00 AM IST (4:30 UTC)"
echo "   • 11:00 AM IST (5:30 UTC)" 
echo "   • 10:00 PM IST (16:30 UTC)"