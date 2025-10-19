# 🚀 Quick Setup Guide

## Option 1: Automated Setup (Recommended)

```bash
# Clone the repository
git clone https://github.com/sagarmajumder2021-afk/auto-linkedin-poster.git
cd auto-linkedin-poster

# Run the setup script
chmod +x setup.sh
./setup.sh
```

## Option 2: Manual Setup

### Step 1: Add LinkedIn Token
1. Go to **Settings** → **Secrets and variables** → **Actions**
2. Click **New repository secret**
3. Name: `LINKEDIN_ACCESS_TOKEN`
4. Value: Your LinkedIn API access token

### Step 2: Update Your LinkedIn URN
Edit `.github/workflows/daily-linkedin-poster.yml` line 67:

```yaml
# Change this line:
"author": "urn:li:person:sagar-majumder-9355b6377",

# To your LinkedIn username:
"author": "urn:li:person:YOUR-LINKEDIN-USERNAME",
```

### Step 3: Test the Workflow
1. Go to **Actions** tab
2. Select **Daily LinkedIn AI Poster**
3. Click **Run workflow**
4. Check your LinkedIn for the post!

## 🔍 Finding Your LinkedIn Username

Your LinkedIn profile URL looks like:
```
https://www.linkedin.com/in/your-username-here/
```

Use `your-username-here` as your LinkedIn URN.

## 🚨 Troubleshooting

### Common Issues:
- **401 Error**: Invalid access token
- **403 Error**: Missing API permissions
- **429 Error**: Rate limit exceeded

### Solutions:
1. Verify your LinkedIn app has `w_member_social` scope
2. Check token expiration
3. Ensure Marketing Developer Platform access

## 📞 Need Help?

Create an issue in this repository with:
- Error message
- Steps you've tried
- Your LinkedIn app configuration (no tokens!)

---

**Ready to automate your LinkedIn presence!** 🤖✨