# TravelMemory — AWS deployment preparation

**Status: deployment configuration prepared; AWS infrastructure NOT deployed or verified.**

Original application: https://github.com/UnpredictablePrashant/TravelMemory

## Repository integration
Fork/clone the original source repository. Copy these files into the root of that repository, preserving `backend/` and `frontend/`. Do not claim the original app source is included in this package.

## Backend
1. On Ubuntu EC2, install Node.js LTS, nginx and git.
2. Create `backend/.env` from `backend.env.example`, set a real MongoDB URI and `PORT=3000`.
3. From `backend/`, run `npm install`, then `node index.js` (or PM2 in production).
4. Install `nginx/backend.conf`, replace `api.example.com` with your own domain, test with `sudo nginx -t` and reload nginx.
5. Check the actual API routes and CORS behavior in source before making it public.

## Frontend
1. Copy `frontend.env.example` to `frontend/.env`, replacing domain.
2. Inspect `frontend/src/urls.js` (or locate `urls.js`) and confirm it reads `process.env.REACT_APP_BACKEND_URL` or set the correct production API endpoint.
3. Run `npm install && npm run build` inside `frontend/`.
4. Serve `frontend/build` via `nginx/frontend.conf` and reload nginx.

## AWS architecture (planned, not provisioned)
- Use 2 EC2 instances across separate Availability Zones, each running React static files and Node backend behind Nginx.
- Create an internet-facing Application Load Balancer with HTTPS listener and ACM certificate.
- Configure target group(s) and health checks on an endpoint confirmed to return HTTP 200. Register both instances; enable health checks and test failure handling.
- Security groups: ALB 443 from internet; EC2 app ports only from ALB SG; SSH only from a trusted admin IP or use SSM. Avoid exposing Node port 3000 publicly.
- Keep MongoDB credentials in protected environment variables or AWS Secrets Manager. Restrict MongoDB network access.

## Cloudflare DNS (planned)
- `app.example.com` CNAME -> actual ALB DNS name.
- `api.example.com` CNAME -> ALB DNS name if separate API host is used.
- Assignment's requested A record: `legacy.example.com` A -> reserved Elastic IP of an EC2 frontend, if needed for demonstration. **This bypasses the ALB**, so prefer the CNAME path for production traffic. Use Cloudflare Full (strict) TLS with valid origin certificate.

## Verification checklist (not completed)
- [ ] Source integrated and pushed to own GitHub repository
- [ ] Backend starts with actual MongoDB connectivity
- [ ] Frontend renders and API calls succeed
- [ ] ALB target group shows 2 healthy targets
- [ ] Cloudflare domain resolves to ALB and HTTPS works
- [ ] Failover tested by stopping one instance
- [ ] Genuine screenshots collected from running services

## Screenshot evidence to capture
1. EC2 instances and security groups
2. Target group healthy targets
3. ALB listeners and DNS
4. Cloudflare DNS records
5. Browser showing working app and developer network requests
6. Terminal output showing Nginx configuration and backend process

## Limitations
AWS Console access was revoked. No live EC2, ALB, Cloudflare records, deployment or screenshots are represented as completed. No real credentials or public endpoints are supplied. Update this README with actual proof after deployment.

## Submission
Push the combined repository to **your own GitHub account**. Then submit its actual URL in Vlearn. The original upstream repository URL is not proof of your assignment work.
